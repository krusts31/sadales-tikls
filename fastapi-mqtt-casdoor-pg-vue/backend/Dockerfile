FROM python:3.10 as base

LABEL maintainer=krusts31

WORKDIR /var/www

COPY ./requirements.txt ./requirements.txt

RUN pip install --no-cache-dir --upgrade -r ./requirements.txt

COPY ./app ./app

#CMD ["uvicorn", "app.main:app", "--proxy-headers", "--host", "0.0.0.0", "--port", "80"]
# add --proxy-headers to tell fast api the it is runing behind a load balancer
# some time you would see --worker here with a number that would create 4 processes of the api
# this would create sort of load balancing but it does not have to be used in case you are using k8s
# and replicas
# Development image
FROM base as dev
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "9001", "--reload"]

# Testing image
FROM base as test
COPY ./app ./app
CMD ["pytest", "./app"]

# Production image
FROM base as prod
COPY ./app ./app
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "9001"]
