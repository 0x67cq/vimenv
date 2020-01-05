package main

type Pvk struct {
	Version     string       `yaml:"version"`
	Dependences []Dependence `yaml:"dependences"`
}

type Dependence struct {
	Plugin Plugin `yaml:"plugin"`
}

type Plugin struct {
	Name    string `yaml:"name"`
	Desc    string `yaml:"desc"`
	URL     string `yaml:"url"`
	Locater string `yaml:"locater"`
	Tag     string `yaml:"tag"`
	Install string `yaml:"install"`
}
