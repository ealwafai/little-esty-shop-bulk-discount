# Little Esty Shop

## Background and Description

"Little Esty Shop" is a group project that requires students to build a fictitious e-commerce platform where merchants and admins can manage inventory and fulfill customer invoices.

## Learning Goals
- Practice designing a normalized database schema and defining model relationships
- Utilize advanced routing techniques including namespacing to organize and group like functionality together.
- Utilize advanced active record techniques to perform complex database queries
- Practice consuming a public API while utilizing POROs as a way to apply OOP principles to organize code

## Requirements
- must use Rails 5.2.x
- must use PostgreSQL
- all code must be tested via feature tests and model tests, respectively
- must use GitHub branching, team code reviews via GitHub comments, and github projects to track progress on user stories
- must include a thorough README to describe the project
- must deploy completed code to Heroku

## Setup

This project requires Ruby 2.7.2.

* Fork this repository
* Clone your fork
* From the command line, install gems and set up your DB:
    * `bundle`
    * `rails db:create`
* Run the test suite with `bundle exec rspec`.
* Run your development server with `rails s` to see the app in action.

## Phases

1. [Database Setup](./doc/db_setup.md)
1. [User Stories](./doc/user_stories.md)
1. [Extensions](./doc/extensions.md)
1. [Evaluation](./doc/evaluation.md)


<img width= "750" alt="Screen Shot 2021-08-02 at 5 40 35 PM" src="https://user-images.githubusercontent.com/77654906/127936691-f3d2e8a9-8c08-4951-894a-f47df6a3170c.png">

# Relational Rails 

## Table of Contents

- [Overview](#overview)
- [Learning Goals](#learning-goals)
- [Tools Used](#tools-used)
- [Getting Started](#getting-started)
- [Features](#features)
- [Database Schema](#database-schema)
- [Contributors](#contributors)

## Overview

[Relational Rails](https://github.com/ElliotOlbright/Relational_Rails) is a week long paired project during Mod 2 of Turing School's Back-End Engineering program.

The goal was to create a functioning Rails Application that can take users through a website and give them the ability to use CRUD commands to Create, Read, Update, and Destroy data while being able to veiw the changes on the website(Rails Application).

## Learning Goals

Learning goals and areas of focus consisted of:
- Design a One-to-Many relationship using a schema designer
- Write migrations to create tables with columns of varying data types and foreign keys.
- Use Rails to create web pages that allow users to CRUD resources
- Create instance and class methods on a Rails model that use ActiveRecord methods and helpers
- Write model and feature tests that fully cover data logic and user behavior

The project home page and requirements can be found [here](https://backend.turing.edu/module2/projects/relational_rails).

## Tools Used
|             |               |               |               |
|   :----:    |    :----:     |    :----:     |    :----:     |
| Ruby 2.7.2  | SQL           | SimpleCov     | Github        |
| Rails       | ActiveRecord  | HoundCI       | VSCode        |
| RSpec       | HTML5         | Capybara      | Launchy       |
| Pry         | CSS3          | ShouldaMatcher| Orderly       |

## Getting Started

**Fork this repository:** [Relational Rails](https://github.com/ElliotOlbright/Relational_Rails

**Clone your forked repository:** Run `git clone` with the copied URL.

**Change Directory into Rails App** Run `cd Relational_Rails` in command line.

**Create, Migrate, and Seed Database** Run `rails db:{create, migrate, seed}` in command line.

**Run Rails Server in Command-Line** Run `rails s` in command line.

**Open Web Browser and go to URL *Localhost:3000*** Enjoy the app :)

## Features

From the main page, the user will be able to navigate through either *Car Dealerships* and their *Cars*, or *Grocery Stores* and their *Groceries*. The user can easily access, manipulate, and sort information from within the database using a bright and colorful interface.

## Database Schema
[![Screen-Shot-2021-07-14-at-8-05-03-PM.png](https://i.postimg.cc/qv7KYrC9/Screen-Shot-2021-07-14-at-8-05-03-PM.png)](https://postimg.cc/PPBNpBy4)

## Contributors

👤  **Elliot Olbright** (Dealership Branch)
- [GitHub](https://github.com/ElliotOlbright)
- [LinkedIn](https://www.linkedin.com/in/elliotolbright/)

👤  **Matt Kragen** (Grocery Store Branch)
- [GitHub](https://github.com/InOmn1aParatus)
- [LinkedIn](https://www.linkedin.com/in/mattkragen/)
