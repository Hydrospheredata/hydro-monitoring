# Data
Supported data sources - S3-compatible object storages.
Supported data format - csv files.
With correct configuration, manager is able to connect to buckets and repeatedly poll object metadata. If there is an unseen object (define unseen object), manager will send discovery requests with it’s metadata and associated model information to all registered plugins.
It will repeatedly send the same file to a plugin, until it sends back an ACK message with an optional data report.