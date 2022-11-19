@extends('layouts.app')

@section('content')
<h2>Administration Page</h2>
@include('partials.search_users',['users' => $users])

@include('partials.tag_management',['tags' => $tags])


@endsection