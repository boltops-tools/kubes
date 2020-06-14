# Structure

Here's an example of a `.kubes` structure:

    .kubes
    ├── config
    │   └── envs
    │       ├── dev.rb
    │       └── prod.rb
    ├── config.rb
    ├── output
    │   └── demo-web
    │       ├── deployment.yaml
    │       └── service.yaml
    ├── resources
    │   └── demo-web
    │       ├── deployment
    │       │   └── dev.rb
    │       ├── deployment.rb
    │       └── service.rb
    └── state
        └── docker_image.txt

Name | Description
--- | ---
config.rb | Baseline config.rb file. Where you set the repo to push the Docker image to.
config | Folder contains layers to override config.rb on a per environment basis. IE: config/envs/dev.rb and config/envs/prod.rb
output | Where the compiled files get written to.
resources | Where you define your kubernetes resources. Can be defined with a DSL or ERB/YAML.
state | Where the `docker_image.txt` is stored after the `kubes docker build` runs.