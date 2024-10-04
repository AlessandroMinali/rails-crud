# Rails CRUD API

The goal of this exercise is to retrieve data from an external source, store it in an appropriate database structure, and create a CRUD RESTful API to interface with the database

## Goals

Read the data from this graphql endpoint: https://swapi-graphql.netlify.app/.netlify/functions/index with the following query:
query Query {allPlanets{planets{name population terrains climates}}}

View the shape of the data here: https://studio.apollographql.com/public/star-wars-swapi/variant/current/explorer

Store the data from the graphql endpoint into the database and create appropriate models
===
Write RESTful Create, Read, Update, and Delete endpoints to interact with the database
===
https://medium.com/@isphinxs/a-cheat-sheet-for-rails-generators-44cf79884ac7  
https://guides.rubyonrails.org  