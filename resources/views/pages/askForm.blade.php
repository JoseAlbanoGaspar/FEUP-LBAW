@extends('layouts.app')
@php

if(isset($text_body)){

}
@endphp
@section('content')

<h2 class="m-2 my-4">Ask Question</h2>

<div class="container-sm m-5 d-flex justify-content-center">
    <div style="width: 30rem;">

    <form method="POST" action="{{ route('postQuestion') }}" enctype="multipart/form-data">
        {{ csrf_field() }}
        @method('POST')

        <!-- ID -->
        <input type="hidden" value="{{ Auth::user()->id_user }}" name="id_author" />

        <!-- title input -->
        <div class="form-outline mb-4">
        <input type="text" name="title" @if(isset($title)) value="{{$title}}" @endif class="form-control" required autofocus/>
        <label class="form-label" for="title">Title</label>
        </div>
        @if ($errors->has('title'))
        <span class="error">
            {{ $errors->first('title') }}
        </span>
        @endif

        <!-- text body input -->
        <div class="form-outline mb-4">
        <textarea  name="text_body" class="form-control" required rows="10">@if(isset($text_body)){{$text_body}}@endif
        </textarea>
        <label class="form-label" for="text_body">Question body</label>
        </div>
        @if ($errors->has('text_body'))
        <span class="error">
            {{ $errors->first('text_body') }}
        </span>
        @endif

        <!-- Tags -->
        <div class="form-outline mb-4">
        <input type="text" name="tag1" class="form-control"/>
        <label class="form-label" for="tag1">Tag 1</label>
        </div>
        @if ($errors->has('tag1'))
        <span class="error">
        {{ $errors->first('tag1') }}
        </span>
        @endif

        <div class="form-outline mb-4">
        <input type="text" name="tag2" class="form-control"/>
        <label class="form-label" for="tag2">Tag 2</label>
        </div>
        @if ($errors->has('tag2'))
        <span class="error">
        {{ $errors->first('tag2') }}
        </span>
        @endif

        <div class="form-outline mb-4">
        <input type="text" name="tag3" class="form-control"/>
        <label class="form-label" for="tag3">Tag 3</label>
        </div>
        @if ($errors->has('tag3'))
        <span class="error">
        {{ $errors->first('tag3') }}
        </span>
        @endif

        <div class="form-outline mb-4">
        <input type="text" name="tag4" class="form-control"/>
        <label class="form-label" for="tag4">Tag 4</label>
        </div>
        @if ($errors->has('tag4'))
        <span class="error">
        {{ $errors->first('tag4') }}
        </span>
        @endif

        <!-- Submit and Go Back button -->
        <div class = "m-4 mx-5 d-flex justify-content-between">
          @include('partials.goBackButton')
          <button type="submit" class="btn btn-primary btn-block">Ask</button>
        </div>

    </form>
  </div>
</div>

@endsection
