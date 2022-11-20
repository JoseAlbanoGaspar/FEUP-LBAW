@extends('layouts.app')

@section('content')

<h2 class="m-2 my-4">Login</h2>

<div class="container-sm m-5 d-flex justify-content-center">
    <div style="width: 30rem;">
        <form method="POST" action="{{ route('login') }}">
            {{ csrf_field() }}

            <!-- Email input -->
            <div class="form-outline mb-4">
            <input type="email" name="email" class="form-control" required autofocus/>
            <label class="form-label" for="email">Email</label>
            </div>
        
    
            <!-- Password input -->
            <div class="form-outline mb-3">
            <input type="password" name="password" class="form-control" required/>
            <label class="form-label" for="password">Password</label>
            </div>

            @if ($errors->has('email'))
                <div class="alert alert-danger" role="alert">
                    {{ $errors->first('email') }}
                </div>
            @endif
            @if ($errors->has('password'))
                <div class="alert alert-danger" role="alert">
                    {{ $errors->first('password') }}
                </div>
            @endif
    
            <!-- 2 column grid layout -->
            <div class="row mb-4">
            <div class="col-md-6 d-flex justify-content-center">
                <!-- Checkbox -->
                <div class="form-check mb-3 mb-md-0">
                <input class="form-check-input" type="checkbox" value="" name="remember" {{ old('remember') ? 'checked' : '' }} />
                <label class="form-check-label" for="remember"> Remember me </label>
                </div>
            </div>
    
            <div class="col-md-6 d-flex justify-content-center">
                <!-- Simple link -->
                <a href="#!">Forgot password?</a>
            </div>
            </div>
    
            <!-- Submit button -->
            <button type="submit" class="btn btn-primary btn-block mb-4">Sign in</button>
    
            <!-- Register buttons -->
            <div class="text-center">
            <p>Not a member? <a href="{{ route('register') }}">Register</a></p>
            </div>
        </form>
    </div>
</div>

@endsection