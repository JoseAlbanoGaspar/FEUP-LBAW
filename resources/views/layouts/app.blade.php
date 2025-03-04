<!DOCTYPE html>
<html lang="{{ app()->getLocale() }}">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- CSRF Token -->
    <meta name="csrf-token" content="{{ csrf_token() }}">

    <title>{{ config('app.name', 'Laravel') }}</title>

    <!-- Styles -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">

    <link href="{{ asset('css/app.css') }}" rel="stylesheet">

    <script type="text/javascript" src={{ asset('js/app.js') }} defer></script>

  </head>
  <body class="d-flex flex-column min-vh-100">
    @include('partials.navBar')

    <main>
      <div class="row">
        <div class="col-md-2 col-12 ">
            @include('partials.sideNav')
        </div>
        <section id = "content" class="col-md-10 col-12 ">
          @yield('content')
        </section>
      </div>
    </main>
    @include('layouts.scripts')
  </body>
    <footer class="footer bg-dark d-flex justify-content-start mt-auto">
      <a href="/" class="text-decoration-none">
        <h3 class="container mb-0 mr-5">
            <small class="text-muted">hELP</small>
        </h3>
      </a>
    </footer>
</html>
