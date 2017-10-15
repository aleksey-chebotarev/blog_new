# Blog 

## Url:
```
https://blog-task-test.herokuapp.com/
```
## Аналитический отчет:
```
База данных была заполнена за период: с 2014 по 2017 год
```
## Эндпоинт для аутентификации:
**Поля:**
- email
- password
```
POST https://blog-task-test.herokuapp.com/api/v1/auth_tokens
```
```
curl -X POST -H 'Accept: application/json' -H 'Content-type: application/json' -d '{"email":"author@example.com", "password":"111111"}' https://blog-task-test.herokuapp.com/api/v1/auth_tokens
```
```
Тестовый пользователь:
email: author@example.com
password: 111111
```
## Эндпоинты для записей в блоге:
**Заголовок**
- X-Auth-Token

**Создать запись:**
- title
- body
- published_at
```
POST https://blog-task-test.herokuapp.com/api/v1/posts
```
```
curl -X POST -H 'Accept: application/json' -H 'Content-type: application/json' -H 'x-auth-token:eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE1MDkwODY1MTZ9.w450uv0555o-nU0lvNpfwVKiF7tIE9o0zPUqPn96efM' -d '{"title":"title", "body":"body", "published_at":"10.10.2016"}' https://blog-task-test.herokuapp.com/api/v1/posts
```
**Получить запись:**
- post_id
```
GET https://blog-task-test.herokuapp.com/api/v1/posts/:post_id
```
```
curl -X GET https://blog-task-test.herokuapp.com/api/v1/posts/102 -H 'Accept: application/json' -H 'Content-type: application/json' -H 'x-auth-token:eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE1MDkwODY1MTZ9.w450uv0555o-nU0lvNpfwVKiF7tIE9o0zPUqPn96efM'
```
**Получить коллекцию записей:**
- page
- per_page
```
GET https://blog-task-test.herokuapp.com/api/v1/posts
```
```
curl -X GET 'https://blog-task-test.herokuapp.com/api/v1/posts?page=1&per_page=2' -H 'Accept: application/json' -H 'Content-type: application/json' -H 'x-auth-token:eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE1MDkwODY1MTZ9.w450uv0555o-nU0lvNpfwVKiF7tIE9o0zPUqPn96efM'
```
## Эндпоинты для комментариев:
**Заголовок**
- X-Auth-Token

**Создать комментарий:**
- comment
    - body
    - published_at
- post_id
```
POST https://blog-task-test.herokuapp.com/api/v1/comments
```
```
curl -X POST -H 'Accept: application/json' -H 'Content-type: application/json' -H 'x-auth-token:eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE1MDkwODY1MTZ9.w450uv0555o-nU0lvNpfwVKiF7tIE9o0zPUqPn96efM' -d '{"comment": {"body":"body", "published_at":"10.10.2016"}, "post_id":"102"}' https://blog-task-test.herokuapp.com/api/v1/comments
```
**Просмотреть комментарий:**
- comment_id
```
GET https://blog-task-test.herokuapp.com/api/v1/comments/:comment_id
```
```
curl -X GET https://blog-task-test.herokuapp.com/api/v1/comments/503 -H 'Accept: application/json' -H 'Content-type: application/json' -H 'x-auth-token:eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE1MDkwODY1MTZ9.w450uv0555o-nU0lvNpfwVKiF7tIE9o0zPUqPn96efM'
```
**Удалить комментарий:**
- comment_id
```
DELETE https://blog-task-test.herokuapp.com/api/v1/comments/:comment_id
```
```
curl -X DELETE https://blog-task-test.herokuapp.com/api/v1/comments/503 -H 'Accept: application/json' -H 'Content-type: application/json' -H 'x-auth-token:eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE1MDkwODY1MTZ9.w450uv0555o-nU0lvNpfwVKiF7tIE9o0zPUqPn96efM'
```
## Эндпоинт для аналитического отчета:
**Создать отчет:**
- start_date
- end_date
- email
```
POST https://blog-task-test.herokuapp.com/api/v1/reports/by_author
```
```
curl -X POST https://blog-task-test.herokuapp.com/api/v1/reports/by_author -H 'Accept: application/json' -H 'Content-type: application/json' -H 'x-auth-token:eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE1MDkwODY1MTZ9.w450uv0555o-nU0lvNpfwVKiF7tIE9o0zPUqPn96efM' -d '{"start_date":"01.01.2016","end_date":"10.10.2017", "email":"email@example.co"}'
```
