
before
---

* need set up environment variable

~~~
http_proxy=***
https_proxy=***
~~~

vagrant plugins
---

~~~
$ vagrant plugin install vagrant-proxyconf
$ vagrant plugin install vagrant-omnibus
$ vagrant plugin install vagrant-vbguest
~~~

gems
---

~~~
$ bundle install
~~~

how to run
---

~~~
$ vagrant up --provision
~~~
