@extends('layouts.app')

@section('content')

<h2 class="m-2 my-4">Login</h2>

<div class="container-sm m-5 d-flex justify-content-center">
    <div style="width: 30rem;">
        <form method="POST" action="{{ route('register') }}">
            {{ csrf_field() }}

            <!-- Username input -->
            <div class="form-outline mb-4">
            <input type="text" name="name" class="form-control" value="{{ old('name') }}" required/>
            <label class="form-label" for="name">Username</label>
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
            <input type="password" name="password-confirm" class="form-control" required/>
            <label class="form-label" for="password-confirm">Repeat password</label>
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
