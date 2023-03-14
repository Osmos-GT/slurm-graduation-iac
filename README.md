# Репозиторий Infrastructure-as-Code для приложения YELB.

Этот репозитарий содержит  код, необходимый для создания и настройки инфраструктуры в Yandex cloud под учебное микросервисное приложение YELB.

Вся работа с инфраструктурой, включая её создание, удаление, установку необходимых helm-чартов выполняются с помощью Gitlab CI.

Предполагается, что этот репозитарий расположен в одной группе с app-репозитарием в Gitlab, что позволяет использовать одно хранилище переменных. Необходимые переменные указаны в описании [App-репозитория](https://github.com/Osmos-GT/slurm-graduation-app).

Более подробно выбранные решения описаны в [отчете о проделанной работе](https://github.com/Osmos-GT/slurm-graduation-app/blob/main/report.md), загруженном в [App-репозитории](https://github.com/Osmos-GT/slurm-graduation-app).

Пайплайн этого репозитория состоит из следующих этапов:

### Lint
Terraform validate. Также согласно ТЗ предусмотрен yamllint, который выполняется параллельно.

### Build
Создание плана.

### Terraform-deploy
Применение плана, сохраненного на предыдущем этапе. Запуск этапа производится вручную, чтобы можно предварительно изучить план. Также на этом этапе создается переменная с адресом БД через API Gitlab.
Все последующие этапы также выполняются вручную, т.к. в них не всегда может быть необходимость (например, не нужно конфигурировать БД, если она не изменяется на этапе деплоя).

### Terraform-destroy-all
Уничтожение инфраструктуры. Удаление переменной с адресом БД через API Gitlab.

### Ingress-install
Установка ingress-контроллера nginx-ingress.
Контроллер будет использовать зарезервированный на этапе деплоя ip-адрес, для которого также автоматически создана dns-запись типа А.

### Certmanager-install
Установка certmanager и применение манифеста cluster issuer.

### Gitlab-runner-install
Получение токена для регистрации раннера, установка в кластер раннера из локального чарта. Установленный раннер регистрируется в Gitlab.

### Redis-install
Установка Redis.

### Db-prepare
Настройка базы данных: создание в ней таблицы определенной структуры.
