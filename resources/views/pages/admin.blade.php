@extends('layouts.app')

@section('content')
<h2>Administration Page</h2>
@include('partials.adminUsers')

@include('partials.tag_management',['tags' => $tags])


@endsection