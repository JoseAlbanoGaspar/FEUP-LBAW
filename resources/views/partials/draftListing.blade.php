@php $truncated = (strlen($draft->text_body) > 473) ? substr($draft->text_body,0,470).'...' :
    $draft->text_body;
    include_once(app_path() . '/Includes/Utils.php');
@endphp

<div id="draft-{{$draft->id_draft}}" class="draftCard card mx-5 my-2">
    <div class = "card-body d-flex justify-content-center p-3">

        <div class="post-summary col-10">

            <div class ="row">
                <a class="text-decoration-none">
                    <h5 class="card-title">@if($draft->title) {{$draft->title}} @else <i> No title given </i> @endif</h5>
                </a>
            </div>

            <div class ="row"><h6 class="card-text">
                    @if($truncated) {{$truncated}} @else <i> Text body missing </i> @endif
                </h6>
            </div>


            <div class="post-summary-meta row d-flex justify-content-between mt-2">


                <div class = "user-card col d-inline d-flex justify-content-end text-wrap">
                    <time class="user-card-time flex-shrink">
                        &nbsp;&nbsp;written {{timeElapsedString($draft->date)}}
                    </time>
                </div>


            </div>
            <div class="flex-row d-flex">
                <div id="complete-draft-{{$draft->id_draft}}" class="complete-draft px-2">
                    <a href="{{route('formToAskQuestion', ['title' => $draft->title, 'text_body' => $draft->text_body])}}" class="btn btn-outline-primary">Complete question</a>
                </div>
                <div id="delete-draft-{{$draft->id_draft}}" class="delete-draft ml-auto px-2">
                    <button class="btn btn-danger">Delete</button>
                </div>
            </div>
        </div>

    </div>
</div>
