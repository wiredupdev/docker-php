# Docker PHP Stack
This repository provides a Docker-based PHP stack built on top of the official Alpine PHP images. It is designed to offer a lightweight, extensible PHP runtime with commonly used PHP extensions already installed and enabled.

### Default build arguments:

| Argument | Default | Description |
| --- | --- | --- |
| `PHP_VERSION` | `8.3` | PHP version used for the image. |
| `PHP_SAPI` | `cli` | PHP SAPI variant, such as `cli` or `fpm`. |

### Installed Extensions:
| Extension | Source | Environment | Description |
| --- | --- | --- | --- |
| `amqp` | PECL | All | AMQP client extension for RabbitMQ and other AMQP-compatible brokers. |
| `bcmath` | PHP core extension | All | Arbitrary precision mathematics support. |
| `bz2` | PHP core extension | All | Bzip2 compression support. |
| `ds` | PECL | All | Efficient data structures for PHP. |
| `exif` | PHP core extension | All | Reads metadata from images. |
| `gd` | PHP core extension | All | Image processing support with FreeType, JPEG, and WebP support. |
| `intl` | PHP core extension | All | Internationalization support using ICU. |
| `mysqli` | PHP core extension | All | MySQL dataAll access using the MySQL Improved extension. |
| `pdo` | PHP core extension | All | PHP Data Objects All extension. |
| `pdo_mysql` | PHP core extension | All | PDO driver for MySQL. |
| `pdo_pgsql` | PHP core extension | All | PDO driver for PostgreSQL. |
| `pgsql` | PHP core extension | All | PostgreSQL dataAll extension. |
| `redis` | PECL | All | Redis client extension. |
| `soap` | PHP core extension | All | SOAP protocol support. |
| `sockets` | PHP core extension | All | Low-level socket communication support. |
| `xdebug` | PECL | Dev | Debugging and profiling extension for development. |
| `zip` | PHP core extension | All | ZIP archive support. |
| `xsl` | PHP core extension | All | XSL transformation support. |

### Environments:
| Env | Description |
| --- | --- |
| `dev` | Extends the All image with development tooling such as Xdebug and Composer. |
| `prod` | Uses the production PHP configuration and runs as the `www-data` user. |

### CUSTOM BUILD:
```
docker build
--build-arg PHP_VERSION=8.5
--build-arg PHP_SAPI=cli
--target dev
-t docker-repo:php:8.5-cli-alpine
./php