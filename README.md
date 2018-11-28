# Docker Surechembl Data Client [ALPHA ]

Dockerized example for [Surechembl Data Client App](https://github.com/chembl/surechembl-data-client). 

>Note: This is a work in progress not intended for production environments. This will be eventually include in the surechembl-data-client repository.

## Getting Started

On the [docker-compose.yml](docker-compose.yml) change the property "volume" under the service "surechembl" to match the location of your surechembl-data-client application, then run:
``` bash
docker-compose up
```

Once the instances are up and running connect to the surechembl machine using:
``` bash
docker exec -it surechembl bash
```

And then follow the procedure on [Surechembl Data Client](https://github.com/chembl/surechembl-data-client#loading-the-backfile) as you would normally do, e.g.,

``` bash
# Replace <ftp-username> and <ftp-password> with the ones provided by ChEMBL
./opt/suredataclient/src/update.py <ftp-username> <ftp-password> sc_client surechembl --date 20180810
```

### Prerequisites

You must have [Docker](https://store.docker.com/search?type=edition&offering=community) installed on your machine and having cloned [Surechembl Data Client App](https://github.com/chembl/surechembl-data-client).

## Authors

* **Ricardo Arcila** - *Initial work* - [ricardoaat](https://github.com/ricardoaat)

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details
