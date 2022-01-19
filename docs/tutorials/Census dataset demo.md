# Getting started with census dataset demo
1. Clone the demo repository. It contains dockerfile with necessary infrastructure, and data files from a model.
2. In the repository run `docker compose up -d`. This will deploy docker containers with monitoring services
3. In `adult` folder, you can see inference and training folders. There is also a Makefile with commands to upload the data to the service.
4. Run `make create_bucket upload_training upload_model` . This will create a bucket in provided minio instance, upload training data, register model in the service.
5. Visit UI at `http://localhost:80` to see your model.
6. Run `make upload_inference_1 upload_inference_2 upload_inference_3` to simulate the upload of production inference data.
7. In the UI you can see that inference data is processed and metrics are produced
The same flow is applicable to other demos in the demo repository.