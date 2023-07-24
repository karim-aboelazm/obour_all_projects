import os, string, random
from fabric.api import *
import subprocess

PROJECT_NAME = os.path.dirname(os.path.abspath(__file__)).split('/')[-1]
PROJECT_DIR = '/home/ubuntu/' + PROJECT_NAME


def install_fixture(fixture):
    with prefix('cd {}'.format(PROJECT_DIR)):
        with prefix('source {}/venv/bin/activate'.format(PROJECT_DIR)):
            run('python3 manage.py loaddata {}'.format(fixture))


def createsuperuser():
    with prefix('cd {}'.format(PROJECT_DIR)):
        with prefix('source {}/venv/bin/activate'.format(PROJECT_DIR)):
            run('python3 manage.py createsuperuser')


def manage(command):
    with prefix('cd {}'.format(PROJECT_DIR)):
        with prefix('source {}/venv/bin/activate'.format(PROJECT_DIR)):
            run('python3 manage.py {}'.format(command))


def update():
    with prefix('cd {}'.format(PROJECT_DIR)):
        run('git pull')
        with prefix('source {}/venv/bin/activate'.format(PROJECT_DIR)):
            run('pip3 install -r requirements.txt')
            run('python3 manage.py migrate --noinput')
            run('python3 manage.py collectstatic --noinput')
            run('python3 manage.py backup')
        sudo('cp infrastructure/nginx.conf /etc/nginx/sites-available/')
        sudo('cp infrastructure/common.conf /etc/nginx/sites-available/')
        sudo('service nginx restart')

        sudo('cp infrastructure/gunicorn.conf /etc/supervisor/conf.d/')
        sudo('supervisorctl reread')
        sudo('supervisorctl update')
        sudo('supervisorctl restart gunicorn')



def keygen():
    run('ssh-keygen -b 2048 -t rsa -f ~/.ssh/id_rsa -q -N ""')


def deploy():
    run("ssh-keyscan -f github.com >> ~/.ssh/known_hosts")
    run(f"git clone git@github.com:OiGrad/{PROJECT_NAME}.git")

    sudo("apt-get update")
    sudo("apt-get --assume-yes  install python3-pip")
    sudo("pip3 install virtualenv")
    sudo("apt-get --assume-yes  install python3-dev libpq-dev postgresql postgresql-contrib")

    # sudo(f"psql -c 'create database {PROJECT_NAME};'", user="postgres")
    rand_pass = ''.join(random.choice(string.ascii_letters + string.digits) for _ in range(20))
    # print("Password: " + rand_pass)
    # sudo(f"psql -c \"create role {PROJECT_NAME} with encrypted password '{rand_pass}';\"", user="postgres")
    # sudo(f"psql -c \"grant all on database {PROJECT_NAME} to {PROJECT_NAME};\"", user="postgres")
    # sudo(f"psql -c \"alter role {PROJECT_NAME} with login;\"", user="postgres")

    sudo("apt --assume-yes  install nginx")
    sudo("apt-get --assume-yes  install supervisor")
    sudo("service supervisor restart")

    with prefix('cd {}'.format(PROJECT_DIR)):
        run("virtualenv -p python3 venv")
        run("mkdir logs")
        run("touch logs/gunicorn.log")
    sudo("sudo ln -s  /etc/nginx/sites-available/nginx.conf /etc/nginx/sites-enabled/")
    sudo("rm /etc/nginx/sites-enabled/default")

    host_name = run("cat /etc/hostname")
    run(f"echo '127.0.0.1 {host_name}' | sudo tee -a /etc/hosts")

    with prefix('cd {}'.format(PROJECT_DIR)):
        run("touch .env")
        SECRET_KEY = ''.join(random.choice(string.ascii_letters + string.digits) for _ in range(50))
        run(f"echo 'SECRET_KEY={SECRET_KEY}' >> .env")
        run("echo 'DEBUG=False' >> .env")
        run(f"echo 'DATABASE_URL=postgres://{PROJECT_NAME}:{rand_pass}@localhost/{PROJECT_NAME}' >> .env")
        host_name = env.hosts[0].split('@')[1]
        run(f"echo 'ALLOWED_HOSTS={host_name}' >> .env")
        run("echo 'STATIC_URL=/static/' >> .env")
        run("echo 'STATIC_ROOT=static/' >> .env")
        run("echo 'MEDIA_URL=/media/' >> .env")
        run("echo 'MEDIA_ROOT=media/' >> .env")
    sudo("sed -i 's/www-data/ubuntu/g' /etc/nginx/nginx.conf")
    update()


def createdefaultsuperuser():
    with prefix('cd {}'.format(PROJECT_DIR)):
        with prefix('source {}/venv/bin/activate'.format(PROJECT_DIR)):
            run('python3 manage.py createdefaultadmin')


env.hosts = ['ubuntu@34.232.188.142']