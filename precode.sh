#!/bin/bash

# создаём каталог task с вложенными директориями
# task
#   dir1
#   dir2
#   dir3
#       dir4

mkdir -p task/dir1
mkdir  task/dir2
mkdir -p task/dir3/dir4

# изменяем текущую директорию на task
cd task

# создаём пустой файл task/dir2/empty
touch task/dir2/empty

# создаём файл task/dir2/hello.sh с таким содержанием:
# #!/bin/bash
# echo "$1, привет!"
#выход из сценария и прекращение в случае ошибки, в том числе в конвейере
set -o pipefail -e
сat << 'EOF' > ./dir2/hello.sh
#!/bin/bash
echo "$1, привет!"
EOF
set +o pipefail +e

# устанавливаем для task/dir2/hello.sh права rwxrw-r--
chmod 764 task/dir2/hello.sh

# сохраняем список файлов task/dir2 в task/dir2/list.txt
ls task/dir2 > task/dir2/list.txt

# копируем содержимое каталога task/dir2 в каталог task/dir3/dir4
cp -r -T task/dir2/ task/dir3/dir4

# записываем в task/dir1/summary.txt список файлов с расширением *.txt
# находящихся в task, включая поддиректории
#выход из сценария и прекращение в случае ошибки, в том числе в конвейере
set -o pipefail -e
#ищем в списке теккущего каталога простые файлы txt и с любыми именами и расширением .txt, записываем
ls | find . -type f -name "*.txt" > task/dir1/summary.txt
set +o pipefail +e

# дописываем в task/dir1/summary.txt содержимое task/dir2/list.txt
#выход из сценария и прекращение в случае ошибки, в том числе в конвейере
set -o pipefail -e
cat task/dir2/list.txt >> task/dir1/summary.txt
set +o pipefail +e

# определяем переменную окружения NAME со значением "Всем студентам"
NAME="Всем студентам"

# запускаем task/dir2/hello.sh с переменной окружения NAME в качестве аргумента
# вывод скрипта должен дописаться в файл task/dir1/summary.txt
#выход из сценария и прекращение в случае ошибки, в том числе в конвейере
set -o pipefail -e
task/dir2/hello.sh $NAME >> task/dir1/summary.txt
set +o pipefail +e

# перемещаем с переименованием task/dir1/summary.txt в task/Практическое задание
mv task/dir1/summary.txt "Практическое задание"

# выводим на консоль содержимое файла task/Практическое задание
cat "Практическое задание"

# ищем в файле "Практическое задание" строки, которые содержат слово "dir"
# и затем отсортировываем их
grep "dir" "Практическое задание" | sort

# меняем текущую директорию на родительскую для task
cd ..

# удаляем директорию task со всем содержимым
rm -r task
