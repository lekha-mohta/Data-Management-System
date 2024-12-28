# COM3420 Software Hut - Team 7

A website for the Advanced Polymer Sintering Laboratory, University of Sheffield.

<!-- markdown-toc start - Don't edit this section. Run M-x markdown-toc-refresh-toc -->
**Table of Contents**

- [COM3420 Software Hut - Team 7](#com3420-software-hut---team-7)
- [Where to find our documents.](#where-to-find-our-documents)
- [Project Layout](#project-layout)
    - [Controllers, Views, Models and Packs](#controllers-views-models-and-packs)
    - [Seeds](#seeds)
    - [Docs folder, sample_files](#docs-folder-sample_files)
    - [Spec folder](#spec-folder)
- [How to run](#how-to-run)
- [How to test](#how-to-test)
    - [Manual tests](#manual-tests)
    - [Automatic testing](#automatic-testing)

<!-- markdown-toc end -->

# Where to find our documents.

The docs folder consists of all the documents necessary for the following project. It includes the Requirements Documents, User Documentation, Design Documentation, and the Risk Register. 

# Project Layout

Since we are using Ruby On Rails, we are using the conventional practices and code layouts that is used by EpiGenesys, roughly described below.

## Controllers, Views, Models and Packs
Inside the `app/` folder, we have a folders for our controllers, views, models and packs.
Packs contains assets such as javascript/css files and images.

## Seeds
For the database we have `seeds.rb` and `testing_seeds.rb` in the `db/` folder.

## Docs folder, sample_files
In the docs folder we have some images that were needed to be easily accessed by our team when developing the application.

The sample files folder contains arbitrary files used to seed the database.

## Spec folder
The spec controller contains all our automated testing using RSpec.

# How to run

You can use our `Makefile` to run our project.

``` sh
make dev
```

Or alternatively run the following commands in different terminals
``` sh
# 1. Rails server
@bin/setup
@bundle exec rails s

# 2. Shakapacker dev server
@bin/shakapacker-dev-server
```

# How to test

## Manual tests

For some of the tests, due to time constraints and not being overly familiar with performing complex actions through `rspec`, we have included `README.md` in the appropriate folders in the `spec/` folder.

## Automatic testing

``` sh
# You can do this by running rspec or rake
bin/rake
# or
rspec
```
