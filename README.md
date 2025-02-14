# Discography Project

Web application built with Ruby on Rails to manage discographies, featuring CRUD functionality for artists and LPs, consolidated reports, and initial seed data.

## Requirements

- **Ruby:** 3.1.0 (recommended)
- **Rails:** 8.0.1
- **Bundler**

## Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/Sob40/discography_project.git
   ```

2. **Navigate to the project directory:**
   ```bash
   cd discography_project
   ```

3. **Install dependencies:**
   ```bash
   bundle install
   ```

4. **Set up the database:**
   ```bash
   rails db:setup
   ```
   This command creates the database, runs migrations, and populates it with initial seed data.

5. **Precompile assets (if necessary):**
   ```bash
   rails assets:precompile
   ```
   If you encounter asset-related issues, clear the cache with:
   ```bash
   rails assets:clobber
   ```

6. **Start the server:**
   ```bash
   rails server
   ```
   Then, open your browser and visit [http://localhost:3000](http://localhost:3000) to access the application.

## Features

- **CRUD for Artists:**  
  Manage artists with name and description fields. The artist detail page displays the total number of LPs associated and includes a link to view them.

- **CRUD for LPs:**  
  Manage LPs with name and description fields, including a filter by artist name.

- **Consolidated Report:**  
  A report page displaying, for each LP, its name, artist, number of songs, and a comma-separated list of song authors.

- **CRUD for Songs and Authors:**  
  Users can add, update, and remove songs from an LP and assign one or more authors to each song using dynamic forms powered by Stimulus and SlimSelect.

- **Seed Data:**  
  Initial data is preconfigured using FactoryBot to facilitate project setup, including various Spanish artists, LPs, songs, and author associations.

- **Enhanced Frontend:**  
  JavaScript (Stimulus) and CSS3 are used to enhance user experience in dynamic forms and reports.

- **Code Quality:**  
  RuboCop has been applied to maintain best practices and code consistency. Run the following command to check code style:
  ```bash
  bundle exec rubocop
  ```

## Additional Notes

- **Asset Pipeline:**  
  The application utilizes asset precompilation. If you experience issues with assets, run `rails assets:clobber` followed by `rails assets:precompile`.

- **Use of Stimulus and SlimSelect:**  
  Dynamic forms for adding and removing songs are implemented using Stimulus, and author selection is enhanced with SlimSelect, providing a modern and smooth user experience.

---

This README provides a clear and professional overview of the project, covering both key functionalities and the tools used for quality and optimization. 🚀
