@extends('layouts.app')

@php

@endphp

@section('content')
  @include('partials.fullquestion', ['post' => $post, 'answers' => $answers])
@endsection
