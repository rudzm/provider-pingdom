package check

import "github.com/crossplane/upjet/pkg/config"

func Configure(p *config.Provider) {
	p.AddResourceConfigurator("pingdom_check", func(r *config.Resource) {
		r.ShortGroup = "check"
	})
}
