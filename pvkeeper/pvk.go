package main

import (
	"fmt"
	"io/ioutil"
	"log"
	"os"
	"os/exec"
	"os/user"
	"path"
	"strings"

	"bytes"
	//"sync"

	"gopkg.in/yaml.v3"
)

var (
	logBuffer = bytes.NewBuffer(nil)
	l         = log.New(logBuffer, "DEBUG: ", log.Llongfile)
)

func triggerLog(logBuffer *bytes.Buffer) {
	f, err := os.OpenFile("./crash.log", os.O_CREATE|os.O_WRONLY, 0644)
	if err != nil {
		log.Fatalf("write log error")
	}
	f.WriteString(logBuffer.String())
}

func main() {

	//develop强制必须有log
	defer func() {
		triggerLog(logBuffer)
	}()

	pvk, err := parseYaml("./pvk.yaml")
	if err != nil {
		triggerLog(logBuffer)
	}
	fmt.Println(pvk)

	// 转换为绝对路径
	for i, v := range pvk.Dependences {
		pvk.Dependences[i].Plugin.Locater = absAddr(v.Plugin.Locater)
	}

	downloads, updates, err := parseLocalPack(pvk)
	if err != nil {
		triggerLog(logBuffer)
	}
	fmt.Println(downloads)
	fmt.Println(updates)
	//// TODO upgrade list

	failchan := make(chan string, len(pvk.Dependences))
	successchan := make(chan string, len(pvk.Dependences))

	for _, v := range downloads {
		fmt.Println("start download: ", v.Name)
		go downloadAndInstallDependence(v, failchan, successchan)
	}

	for i := 0; i < len(pvk.Dependences); i++ {
		select {
		case n := <-failchan:
			l.Println("name: ", n, " need redownload")
		case n := <-successchan:
			l.Println("name: ", n, " success")
		}
	}

	if len(failchan) > 0 {
		// TODO 优化清理方式233
		// errClear(downloads)
		for _, v := range downloads {
			c := exec.Command("rm", "-rf", v.Locater)
			err := c.Run()
			if err != nil {
				l.Println("clear env error")
			}
			triggerLog(logBuffer)

		}
	}

}

func parseYaml(filepath string) (*Pvk, error) {
	pvk := new(Pvk)
	f, err := os.OpenFile(filepath, os.O_RDONLY, 0755)
	if err != nil {
		l.Println("err: ", err.Error())
		return nil, err
	}
	b, err := ioutil.ReadAll(f)
	if err != nil {
		l.Println("err: ", err.Error())
		return nil, err
	}
	// milestone
	fmt.Println("读取依赖文件")
	fmt.Println(string(b))

	err = yaml.Unmarshal(b, pvk)
	if err != nil {
		l.Println("err: ", err.Error())
		return nil, err
	}
	// milestone
	fmt.Printf("解析pvk结构体: %+v", pvk)
	return pvk, nil
}

func downloadAndInstallDependence(p Plugin, fail, success chan string) {
	// download
	fmt.Println("start download ", p.Name, "url : ", p.URL, "in:", p.Locater)
	cmd := exec.Command("git", "clone", p.URL, path.Join(p.Locater, p.Name))
	stderr, err := cmd.StderrPipe()
	if err != nil {
		log.Fatal(err)
	}
	if err := cmd.Start(); err != nil {
		fail <- p.Name
		l.Println("name: ", p.Name, " err: ", err.Error())
		return
	}

	slurp, _ := ioutil.ReadAll(stderr)
	fmt.Printf("aaa %s\n", slurp)

	if err := cmd.Wait(); err != nil {
		fail <- p.Name
		l.Println("name: ", p.Name, " err: ", err.Error())
		return
	}

	// checkout version
	if p.Tag != "" {
		cmd := exec.Command("git", "checkout", p.Tag)
		err := cmd.Run()
		if err != nil {
			fail <- p.Name
			l.Println("name: ", p.Name, " err: ", err.Error())
			return
		}
	}

	// Install
	if p.Install != "" {
		installcmd := strings.Split(p.Install, " ")
		cmd := exec.Command(installcmd[0], installcmd[1:]...)
		err := cmd.Run()
		if err != nil {
			fail <- p.Name
			l.Println("name: ", p.Name, " err: ", err.Error())
			return
		}
	}
	success <- p.Name
	return
}

func updateDependence(p Plugin, fail, success chan string) {
	// TODO update
	// chdir
	// check local version whether equal yaml config verson
	// run git pull
	// checkout version

}

func parseLocalPack(pvk *Pvk) ([]Plugin, []Plugin, error) {
	// 判断有无文件夹
	var downloads []Plugin
	var updates []Plugin
	for _, v := range pvk.Dependences {
		fmt.Println("parse v.Plugin.Locater ing...")
		if _, err := os.Stat(v.Plugin.Locater); err == nil {
			updates = append(updates, v.Plugin)
		}
		downloads = append(downloads, v.Plugin)
	}
	return downloads, updates, nil
	// TODO 更深的可以去做updates的版本判断
}

func absAddr(relative string) string {
	u, err := user.Current()
	if err != nil {
		fmt.Println("get user.Current err: ", err.Error())
	}
	return strings.Replace(relative, "~", u.HomeDir, 1)
}
