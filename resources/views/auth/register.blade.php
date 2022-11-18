@extends('layouts.app')

@section('content')

<h2 class="m-2 my-4">Login</h2>

<div class="container-sm m-5 d-flex justify-content-center">
    <div style="width: 30rem;">
        <form method="POST" action="{{ route('register') }}" enctype="multipart/form-data">
            {{ csrf_field() }}

            <!-- Username input -->
            <div class="form-outline mb-4">
            <input type="text" name="username" class="form-control" value="{{ old('username') }}" required/>
            <label class="form-label" for="username">Username</label>
            </div>
            @if ($errors->has('username'))
            <span class="error">
                {{ $errors->first('username') }}
            </span>
            @endif

            <!-- Email input -->
            <div class="form-outline mb-4">
            <input type="email" name="email" class="form-control"  value="{{ old('email') }}" required/>
            <label class="form-label" for="email">Email</label>
            </div>
            @if ($errors->has('email'))
            <span class="error">
                {{ $errors->first('email') }}
            </span>
            @endif
            
            <!-- Profile image -->
            <input id="profile_picture" type="file" class="form-control" name="profile_picture">
            <label for="profile_picture" class="col-md-4 control-label">Profile Picture</label>
            
            <!-- Personal text input -->
            <div class="form-outline mb-4">
              <textarea name="personal_text" class="form-control" rows="5"></textarea>
              <label class="form-label" for="personal_text">Personal Text</label>
            </div>
            @if ($errors->has('personal_text'))
            <span class="error">
                {{ $errors->first('personal_text') }}
            </span>
            @endif
            <!-- Password input -->
            <div class="form-outline mb-4">
            <input type="password" name="password" class="form-control" required/>
            <label class="form-label" for="password">Password</label>
            </div>
            @if ($errors->has('password'))
            <span class="error">
                {{ $errors->first('password') }}
            </span>
            @endif

            <!-- Repeat Password input -->
            <div class="form-outline mb-4">
            <input type="password" name="password_confirmation" class="form-control" required/>
            <label class="form-label" for="password_confirmation">Repeat password</label>
            </div>

            <!-- Checkbox -->
            <div class="form-check d-flex justify-content-center mb-4">
            <input class="form-check-input me-2" type="checkbox" value="" id="registerCheck" checked
                aria-describedby="registerCheckHelpText" />
            <label class="form-check-label" for="registerCheck">
                I have read and agree to the terms
            </label>
            </div>

            <!-- Submit button -->
            <button type="submit" class="btn btn-primary btn-block mb-3">Sign in</button>
        </form>

        <!-- Login button -->
        <div class="text-center">
            <p>Already have an account? <a href="{{ route('login') }}">Login</a></p>
        </div>
    </div>
</div>

@endsection
