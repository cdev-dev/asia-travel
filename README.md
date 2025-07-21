# Asia Travel - Viajes por Asia (App Flutter)

**Asia Travel** es una aplicación móvil multiplataforma desarrollada en **Flutter** y **Dart** que ofrece una experiencia interactiva para descubrir destinos turísticos en Asia. La app está diseñada para Android (compatible con iOS).

## 📱 Características principales

- Listado de destinos asiáticos con imágenes, descripciones y tours categorizados.
- Detalle de destinos con galería, mapa interactivo (Google Maps y Places API) y datos culturales desde Wikipedia.
- Tours con itinerarios, imágenes, comentarios y opciones de favoritos y solicitud de presupuesto.
- Blog de viajes con artículos enriquecidos, búsqueda y opciones para compartir.
- Formulario de contacto con validación y enlaces directos a WhatsApp.
- Perfil de usuario para gestión de preferencias, favoritos e historial.
- Tema claro/oscuro con selector manual o automático.
- Soporte offline básico mediante caché de datos.
- Animaciones y transiciones suaves.
- Diseño responsive y accesible.

## 🛠 Tecnologías usadas

- Flutter & Dart  
- Provider / Riverpod (gestión del estado)  
- Google Maps & Places API  
- Wikipedia API (para datos culturales)  
- JSON para datos mock externos  
- GitHub Pages para alojar assets (imágenes y JSON)  

## 📂 Estructura del proyecto

  /lib
    /models       # Modelos de datos
    /providers    # Providers para estado
    /screens      # Pantallas principales
    /widgets      # Componentes UI reutilizables
    /services     # Consumo API, Google Maps, Wikipedia
  /assets         # Recursos locales mínimos (ej: iconos)
  /config        # Configuraciones globales (URLs, keys)
  /test          # Tests unitarios y widget tests
  
## 🎯 Objetivo del proyecto

  Demo funcional para portfolio personal que demuestra habilidades en:
   - Desarrollo Flutter multiplataforma.
   - Diseño UI/UX móvil moderno.
   - Consumo y manejo de APIs externas.
   - Arquitectura limpia y modular.
   - Integración de servicios externos.
   - Buenas prácticas de código y gestión del estado.
