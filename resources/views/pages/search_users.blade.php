@extends('layouts.app')

@section('title', 'User Search')

@section('content')
    @include('partials.search_users',['users' => $users])
@endsection
