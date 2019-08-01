# docker-chefdk

Opinionated chefdk setup

## Setup

After installing `docker`, pull the image from docker hub by running: 

```bash
docker pull devoaca/chefdk
```

Also, you should copy the `chefdk` script from `misc/` to a directory that is in your `PATH`. Add execution permissions.

Alternatively you can build the image by cloning this repo and running:

```bash
docker build . -t 'local/chefdk:latest'
```

If you built it locally, copy `chefdk-local` from `misc/` to somewhere in your `PATH` and rename it (the copy) as `chefdk`. Add execution permissions.

## Configuration

If you take a look into the `chefdk` script, you'll notice that it assumes that you have some configuration under `~/.config/chef/`. The file structure for this config might look as follows:

```
.
├── chef-server-01
│   ├── org-01
│   │   ├── config.rb
│   │   ├── credentials
│   │   └── user.pem
│   ├── org-02
│   │   ├── config.rb
│   │   ├── credentials
│   │   └── user.pem
│   └── org-03
│       ├── config.rb
│       ├── credentials
│       └── user.pem
└── chef-server-02
    ├── org-01
    │   ├── config.rb
    │   ├── credentials
    │   └── user.pem
    ├── org-02
    │   ├── config.rb
    │   ├── credentials
    │   └── user.pem
    └── org-03
        ├── config.rb
        ├── credentials
        └── user.pem
```

### Configuration files

The documentation about `config.rb` can be found [here](https://docs.chef.io/knife_setup.html#config-rb-configuration-file). Example:

```ruby
cookbook_copyright 'All rights reserved'
cookbook_email 'my@mycompany.com'
cookbook_license 'All rights reserved'

knife[:format] = 'json'
knife[:supermarket_site] = 'https://supermarket.mycompany.com'
```

Follow [this link](https://docs.chef.io/knife_setup.html#knife-profiles) to get more information about the credentials file. Example:

```yaml
[default]
client_name     = 'user'
client_key      = '/home/chefdk/.chef/user.pem'
chef_server_url = 'https://chef-server-01.example.net/organizations/org-01'
```

You should get `user.pem` from the chef server.

## Use it

Once you have your `chefdk` script in the right place, just run it.
