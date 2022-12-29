@extends('layouts.app')

@section('content')

    <h2 class="m-2 my-4">Register</h2>
    <div class="container-sm m-5 d-flex justify-content-center">
        <div style="width: 30rem;">
            <form method="POST" action="{{ route('resetPasswordAction') }}" enctype="multipart/form-data">
                {{ csrf_field() }}

                <input type="hidden" name="token" value="{{ $token }}">

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
                    <input type="password" name="password_confirmation" class="form-control" required/>
                    <label class="form-label" for="password_confirmation">Repeat password</label>
                </div>


                <!-- Submit button -->
                <button type="submit" class="btn btn-primary btn-block mb-3">Reset password</button>
            </form>

        </div>
    </div>
@endsection
