@extends('layouts.app')

@php
    use App\Models\Post;
@endphp

@section('content')
    @include('partials.question-card', ['post' => Post::find(1)])
    @include('partials.question-card', ['post' => Post::find(1)])
    @include('partials.question-card', ['post' => Post::find(1)])
    @include('partials.question-card', ['post' => Post::find(1)])
    @include('partials.question-card', ['post' => Post::find(1)])
@endsection
