# Plugins
A plugin is a service that uses GRPC API to communicate with manager service, and can provide it’s own web UI.
A plugin is a web service that MUST use  [GRPC API for plugin management](https://github.com/Hydrospheredata/monitoring-manager/blob/master/src/main/protobuf/monitoring_manager.proto) 
Plugins can expose their own web UI as a module that will be attached to our UI. The HTTP requests sent from the web UI are to be proxied by manager.
Lifecycle of a plugin:
1. (Optional) Internal initialization of a plugin.
2. (If plugin provides web UI) Start HTTP server.
3. Call PluginManagementService.RegisterPlugin GRPC method with plugin info.
4. Call ModelCatalogService.GetModelUpdates to get endless stream of models to work with.
5. (Optional) Process training data of models.
6. Call DataStorageService.GetInferenceDataUpdates to get endless stream of inference files of a model.
7. (Optional) Process inference data of models.