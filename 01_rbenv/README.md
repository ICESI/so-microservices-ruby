## Tutorial rbenv en Ubuntu 16.04.2

Instalar rbenv y bundler
```
$ sudo apt instal rbenv
$ sudo apt install ruby-build ruby-dev
$ sudo gem install bundler
```

Crear o modificar el bash_profile para la activación de rbenv
```
$ vi ~/.bash_profile
```
```
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
```

Aplicar los cambios del bash_profile sin reiniciar
```
$ source ~/.bash_profile
```

Listar las versions de ruby disponibles para instalar con rbenv
```
$ rbenv install -l
```

### Instalando una version de ruby (2.2.3)

Instalar una version de ruby
```
$ rbenv install 2.2.3
$ rbenv rehash
```

Crear un directorio para un proyecto y activar un ambiente local de rbenv
```
$ mkdir sinatra-example
$ cd sinatra-example
$ rbenv local 2.2.3
```

verificar la version local de ruby
```
$ ruby -v
```

Observar como que se ha creado el archivo .ruby-version
```
$ cat .ruby-version
```

Crear los archivos de gemas y código fuente
```
$ vi Gemfile
```
```
source 'https://rubygems.org'
gem 'sinatra'
```
```
$ vi example.rb
```
```
require 'sinatra'
get '/frank-says' do
    'Put this in your pipe & smoke it!'
end
```

Ejecutar el siguiente comandos para crear un directorio .env con las gemas requeridas para el proyecto.
```
$ bundle install --path .env
```

Verificar que se ha creado la siguiente estructura:
```
.env
  ruby
    2.2.3
      bin
      build_info
      cache
      doc 
      extensions
      gems 
      specifications
```

El siguiente comando permite obtener información sobre el ambiente creado con bundle
```
$ bundle env
```

Ejecutar el ejemplo
```
$ bundle exec ruby example.rb
```

### Usando la version de ruby del sistema (2.3.1)

rbenv permite cambiar la version de ruby y con bundle se instalan las gemas apropiadas para dicha version
En el directorio del proyecto ejecutar los siguientes comandos:
```
$ rbenv local system
$ ruby -v
$ bundle install --path .env
$ bundle exec ruby example.rb
```

Nota: verificar en el directorio .env que se ha creado un folder por cada version de ruby y que las gemas se encuentran
dentro de esos directorios
