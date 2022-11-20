@extends('layouts.app')

@section('title', 'User Search')

@section('content')
    @include('partials.searchUsers',['users' => $users])
@endsection
