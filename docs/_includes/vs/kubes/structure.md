### Kubes Project Structure

On the other hand, Kubes defines a conventional project structure. Here's a project directory example:

    .kubes/resources
    ├── base
    │   ├── all.yaml
    │   └── deployment.yaml
    ├── shared
    │   └── namespace.yaml
    └── web
        ├── deployment
        │   ├── dev.yaml
        │   └── prod.yaml
        ├── deployment.yaml
        └── service.yaml

A Kubes project structure also supports introduces a role concept or folder. The folder structure only shows a web role for simplicity. You can always add more roles.  For example:

    .kubes/resources/ROLE/deployment.yaml
    .kubes/resources/clock/deployment.yaml
    .kubes/resources/web/deployment.yaml
    .kubes/resources/worker/deployment.yaml
