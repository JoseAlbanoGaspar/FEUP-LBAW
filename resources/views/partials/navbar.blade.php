@php
    if(Auth::check()){
        $user = Auth::user();
    }
    $currentRoute = Route::currentRouteName();
    if ($currentRoute === 'search' && isset($_GET['query'])) {
        $query = $_GET['query'];
    }
    else{
        $query = '';
    }
@endphp

<nav class="navbar navbar-expand navbar-dark bg-dark rounded">
    <a class="navbar-brand mx-lg-5 mx-md-4 mx-2" href="/"><h3>hELP</h3></a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar-content" aria-controls="navbar-content" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>



    <div class="d-flex justify-content-between collapse navbar-collapse" id="navbar-content">

        <form id= "search-bar" class="d-flex flex-row mx-3" method="get" action="{{route('search')}}">
          <input class="form-control mx-2" type="text" name='query' placeholder="Search " value="{{$query}}">
          <button class="btn btn-primary" type="submit"><i class="fa fa-search"></i></button>
        </form>

        <ul class="navbar-nav mx-lg-5 mx-md-4 mx-2">
            <li class = "nav-item">
                @if(Auth::check())

                <a class="nav-link" id="profile-button" href="{{route('users', ['id_user'=> $user->id_user])}}">


                    <img src="{{asset($user->profile_picture)}}" alt="User avatar" width="24" height="24" class="bar-sm ">
                </a>
                @else
                <li class="nav-item" id="login-button">
                    <a class="nav-link" href="{{route('login')}}"><i class="fa fa-sign-in"></i></a>
                </li>
                @endif
            <li class="nav-item">
              <a class="nav-link" href="#"><i class="fa fa-inbox"></i></a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#"><i class="fa fa-question-circle"></i></a>
            </li>
            @auth
            <li class="nav-item" id="logout-button">
              <a class="nav-link" href="{{route('logout')}}"><i class="fa fa-sign-out"></i></a>
            </li>
            @endauth
       </ul>


    </div>

</nav>
