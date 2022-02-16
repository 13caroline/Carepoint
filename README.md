# Carepoint 

<p align="center">
  <img src="https://github.com/RicardoJSFerreira/PI/blob/main/Frontend/web/src/assets/logo.png" height="150" width="370" >
</p>

Within the curricular unit of **IT Project**, the development of a startup was proposed, in order to understand and learn the process of starting a business, from the creation of an idea and carrying out the value proposition, to its development and application ([Financial report](https://github.com/13caroline/carepoint/blob/main/An%C3%A1lise%20Financeira/Relatorio_Financeiro_RunTime%20Terror.pdf)).
    
For this purpose, we developed a platform that allows the interaction of two entities (consumers and care providers) aiming to contribute to the seniors' physical and psychological well-being by strengthening the network of caregivers and valuing the elderly in society as wells of knowledge and experience ([Technical report](https://github.com/13caroline/Carepoint/blob/main/PI_Relat%C3%B3rio_T%C3%A9cnico(RunTime%20Terror).pdf)).

## Tools
* **Frontend**: Vue.js + Vuetify
* **Backend**: Node.js
* **Database**: MySQL Workbench

## How to run the project

1. Change the database's username and password in __Backend/api-server/models/Config/Database_Info.js__;
2. Change the database's username and password in __Backend/auth-server/models/Config/Database_Info.js__;
3. Do 
~~~
cd ./Backend/api-server/
npm i
node ./bin/www 
~~~

4. Do
~~~
cd ./Backend/auth-server/
npm i
node ./bin/www 
~~~

5. In *MySQL Workbench*, run __povoamento.sql__ from __Database/povoamento__ 
6. In *MySQL Workbench*, run __all_queries.sql__ from __Database/sql__ 

7. Do
~~~
cd ./Frontend/web
npm i
node npm run serve
~~~

## Collaborators

| Name            	|
|-----------------	|
| [Bruno Veloso](https://github.com/brunocv)      	|
| [Carolina Cunha](https://github.com/13caroline)  	|
| [Cecília Soares](https://github.com/soaresCecilia) |
| [Filipa Silva]() |
| [Hugo Faria](https://github.com/HugoOSFaria) |
| [João Diogo Mota](https://github.com/JoaoDiogoMota) 	|
| [Luís Abreu](https://github.com/luisabreu102030) |
| [Ricardo Ferreira](https://github.com/RicardoJSFerreira)      	|
| [Rodolfo Silva](https://github.com/Th0l)      	|

<br>

> <img src="https://seeklogo.com/images/U/Universidade_do_Minho-logo-CB2F98451C-seeklogo.com.png" align="left" height="48" width="48" > University of Minho, Software Engineering (5th Year).
