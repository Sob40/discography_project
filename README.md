# Discography Project

Aplicación web en Ruby on Rails para gestionar discografías, con funcionalidades de CRUD para artistas y LPs, reportes consolidados y seeds para datos iniciales.

## Requerimientos

- **Ruby:** (versión recomendada, por ejemplo, 3.1.0)
- **Rails:** 8.0.1
- **Bundler**

## Instalación

1. **Clonar el repositorio:**
   ```bash
   git clone https://github.com/Sob40/discography_project.git
   ```

2. **Entrar en el directorio del proyecto:**
   ```bash
   cd discography_project
   ```

3. **Instalar las dependencias:**
   ```bash
   bundle install
   ```

4. **Configurar la base de datos:**
   ```bash
   rails db:setup
   ```
   Esto creará la base de datos, ejecutará las migraciones y poblará la BD con los datos iniciales (seeds).

5. **Iniciar el servidor:**
   ```bash
   rails server
   ```
   Luego, abre tu navegador en [http://localhost:3000](http://localhost:3000) para ver la aplicación en funcionamiento.

## Características

- **CRUD para Artistas:** Gestión de artistas con campos de nombre y descripción. En la vista de detalle se muestra el total de LPs asociados y un enlace para verlos.
- **CRUD para LPs:** Gestión de LPs con campos de nombre y descripción, incluyendo la posibilidad de filtrar por el nombre del artista.
- **Reporte Consolidado:** Página de reporte que muestra, para cada LP, el nombre del LP, el artista, el número de canciones y una lista de autores.
- **Seeds:** Datos iniciales configurados para facilitar la puesta en marcha del proyecto.
- **Frontend Mejorado:** Uso de JavaScript y CSS3 para mejorar la experiencia de usuario.
