<div id="mainbar" class="p-5" aria-label="question and answers">

	<div id="question">

		<h1 id='question-title'>
			{{$post->question->title}}
		</h1>
		<small id='modified'>This question has been modified(FALTA AQUI) by <a>Joao7890</a> 2 hours ago</small>
		
		<div class="post-layout d-flex flex-row">
			<div class="flex--item">
				@include('partials.votebutton', ['post' => $post->question])
			</div>


			<div class="flex--item w-100">

				<p id='post-text-body' class="p-3">{{$post->text_body}}</p>

				<div class="d-flex flex-row fw-wrap justify-content-between m-2">
					<ul class="d-inline p-2">
						@foreach ($post->question->tags as $tag)
							<li class="d-inline mr4"><a href="" class="post-tag" aria-label="show questions tagged '{{$tag->name}}'"></a>{{$tag->name}}</li>
						@endforeach
					</ul>
					<small class="d-inline p-2">
						<a>{{$post->user->username}}</a> asked 1(FALTA)day ago
					</small>
				</div>

				@include('partials.comments', ['comments' => $post->question->comments])
			</div>
		</div>
	</div>
	


	<div id="answers">
		<div id="answers-header">
			<h2 class="mb0" data-answercount="2">
				<span itemprop="answerCount">{{count($answers)}}</span> Answers
			</h2>
		</div>
		
		@foreach ($answers as $answer)
		<div class="post-layout d-flex flex-row">
			<div class="flex--item">
				@include('partials.votebutton', ['post' => $answer])
			</div>


			<div class="flex--item m-2 w-100">

				<p id='post-text-body' class="p-3">{{$answer->post->text_body}}</p>

				<div class="d-flex flex-row fw-wrap p-2">
					<small>
						<a>{{$answer->post->user->username}}</a> answered 1(FALTA)day ago
					</small>
				</div>

				@include('partials.comments', ['comments' => $answer->comments])
			</div>
		</div>
		@endforeach

		<form id="post-form" action="/questions/{{$post->id_post}}/answer/submit" method="post">
			<h2 class="space" id="your-answer-header">
				Your Answer
			</h2>
			<textarea class="form-control" aria-label="Add answe" placeholder="Add answer"></textarea>
			<div class="form-submit clear-both d-flex flex-row">
				<button id="submit-button" class="btn btn-outline-secondary" type="submit">
					Post Your Answer </button>
				<button class="btn btn-outline-secondary">
					Discard
				</button>
			</div>
		</form>
	</div>
</div>