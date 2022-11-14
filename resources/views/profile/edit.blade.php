@extends('layouts.app')

@section('content')
<form method="POST" action=""> <!-- ROUTE -->
    {{ csrf_field() }}

    <label for="name">Name</label>
    <input id="name" type="text" name="name" value="{{ $user->username }}" required autofocus>
    @if ($errors->has('name'))
      <span class="error">
          {{ $errors->first('name') }}
      </span>
    @endif

    <label for="email">E-Mail Address</label>
    <input id="email" type="email" name="email" value="{{ $user->email }}" required>
    @if ($errors->has('email'))
      <span class="error">
          {{ $errors->first('email') }}
      </span>
    @endif

    <label for="personal_text">Personal Text</label>
    <textarea id="personal_text" type="text" name="personal_text" autofocus>
    {{ $user->personal_text }}
    </textarea>
    @if ($errors->has('name'))
      <span class="error">
          {{ $errors->first('name') }}
      </span>
    @endif

    <label for="password">Password</label>
    <input id="password" type="password" name="password">
    @if ($errors->has('password'))
      <span class="error">
          {{ $errors->first('password') }}
      </span>
    @endif

    <label for="password-confirm">Confirm Password</label>
    <input id="password-confirm" type="password" name="password_confirmation">

    <button type="submit">
      Edit
    </button>
</form>
@endsection
