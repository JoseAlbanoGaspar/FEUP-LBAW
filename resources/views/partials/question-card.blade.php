{{-- import class User--}}
@php
    use App\Models\User;
@endphp

<div class="question-card card mx-5 my-2">
    <div class = "card-body d-flex justify-content-center">
        <div class="question-stats col-2 d-flex justify-content-around flex-column">


            <div class="question-stats-item">
                <span class="question-stats-score-number">0</span>
                <span class="question-stats-score-unit">votes</span>
            </div>
            <div class="question-stats-item">
                <span class="question-stats-score-number">0</span>
                <span class="s-post-summary--stats-item-unit">answers</span>
            </div>

        </div>
        <div class="post-summary col-10">

            <div class ="row"><a href="#"><h5 class="card-title">Notice period in a business contract</h5></a></div>


            <div class="post-summary-meta row d-flex justify-content-between">
                <div class="col d-flex justify-content-start">
                    <ul class="post-summary-meta-tags list-ls-none d-inline">
                        <li class="d-inline mr4"><a href="#" class="post-tag flex--item mt0">contract-law</a></li>
                        <li class="d-inline mr4"><a href="#" class="post-tag flex--item mt0">notice</a></li>
                        <li class="d-inline mr4"><a href="#" class="post-tag flex--item mt0">freelance</a></li>
                    </ul>
                </div>


                @include('partials.profile-card', ['user' => User::find(1)]);



            </div>
        </div>
    </div>
</div>
