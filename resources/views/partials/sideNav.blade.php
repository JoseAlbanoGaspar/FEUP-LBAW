<ul id="sidenav" class="nav nav-pills flex-column mb-auto mt-2">
    <li class="nav-item text-center my-1 fs-6" >
      <a id="homepage-sidenav" class="nav-link link-dark" href="{{route('home')}}">Homepage</a>
    </li>
    @auth
    <li class="nav-item text-center my-1 fs-6">
      <a  id="personalfeed-sidenav"class="nav-link link-dark" href="{{route('personalFeed')}}">Personal Feed</a>
    </li>
    @endauth

    <li class="nav-item text-center my-1 fs-6">
      <a id="questions-sidenav" class="nav-link link-dark" href="{{route('allQuestions')}}">Questions</a>
    </li>

    <li class="nav-item text-center my-1 fs-6">
      <a id="tags-sidenav" class="nav-link link-dark" href="{{route('tags')}}">Tags</a>
    </li>

    <li class="nav-item text-center my-1 fs-6">
      <a id="users-sidenav" class="nav-link link-dark" href="{{route('searchUsers')}}">Users</a>
    </li>
</ul>

