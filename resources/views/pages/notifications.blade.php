@extends('layouts.app')


@section('content')
    @if((count($notifications) > 0))
        <section id="notifications">
            @each('partials.notificationListing', $notifications, 'notification')
        </section>
        @if ($notifications->links()->paginator->hasPages())
            <div class="mt-4 p-4 box has-text-centered">
                {{ $notifications->withQueryString()->links() }}
            </div>
        @endif
    @else
        <div class="d-flex flex-row" ><i>No new notifications</i>&nbsp</div>
    @endif

@endsection
