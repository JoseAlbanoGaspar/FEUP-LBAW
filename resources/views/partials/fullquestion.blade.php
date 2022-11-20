<div id='question'>
	<div id='question-body-grid'>
	</div>
</div>
<div id='answers'>

</div>

<div class="inner-content clearfix">


	<div id="mainbar" class="p-5" role="main" aria-label="question and answers">

		<div id="question">

			<h1 id='question-title'>
				{{$post->question->title}}
			</h1>
			<small id='modified'>This question has been modified(FALTA AQUI) by <a>Joao7890</a> 2 hours ago</small>
			
			<div class="post-layout d-flex flex-row">
				<div class="flex--item">
					@include('partials.votebutton', ['post' => $post->question])
				</div>


				<div class="flex--item">

					<p id='post-text-body'>{{$post->text_body}}</p>

					<div class="d-flex flex-row ps-relative fw-wrap">
						<ul class="ml0 list-ls-none d-inline">
							@foreach ($post->question->tags as $tag)
								<li class="d-inline mr4"><a href="" class="post-tag" aria-label="show questions tagged '{{$tag->name}}'"></a>{{$tag->name}}</li>
							@endforeach
						</ul>
						<small>
							<a>{{$post->user->username}}</a> asked 1(FALTA)day ago
						</small>
					</div>

					@include('partials.comments', ['comments' => $post->question->comments])
				</div>
			</div>
		</div>
		


		<div id="answers">
			<a name="tab-top"></a>
			<div id="answers-header">
				<div class="answers-subheader d-flex ai-center mb8">
					<div class="flex--item fl1">
						<h2 class="mb0" data-answercount="2">
							{{count($answers)}} Answers
							<span style="display:none;" itemprop="answerCount">2</span>
						</h2>
					</div>
					{{--	SORT BY
					<div class="flex--item">
						<div class="d-flex g4 gsx ai-center sm:fd-column sm:ai-start">
							<div class="d-flex fd-column ai-end sm:ai-start">
								<label class="flex--item fs-caption" for="answer-sort-dropdown-select-menu">
									Sorted by:
								</label>
								<a class="js-sort-preference-change s-link flex--item fs-fine d-none" data-value="ScoreDesc" href="/questions/85675/what-are-equity-and-equitable-remedies?answertab=scoredesc#tab-top">
									Reset to default
								</a>
							</div>
							<div class="flex--item s-select">
								<select id="answer-sort-dropdown-select-menu">
									<option value="scoredesc" selected="selected">
										Highest score (default)
									</option>
									<option value="modifieddesc">
										Date modified (newest first)
									</option>
									<option value="createdasc">
										Date created (oldest first)
									</option>
								</select>
							</div>
						</div>
					</div>
					--}}
				</div>
			</div>
			
			@foreach ($answers as $answer)
				<div class="post-layout d-flex flex-row">
					<div class="flex--item">
						@include('partials.votebutton', ['post' => $answer])
					</div>


					<div class="flex--item">

						<p id='post-text-body'>{{$answer->post->text_body}}</p>

						<div class="d-flex flex-row ps-relative fw-wrap">
							<small>
								<a>{{$answer->post->user->username}}</a> answered 1(FALTA)day ago
							</small>
						</div>

						@include('partials.comments', ['comments' => $answer->comments])
					</div>
				</div>
			@endforeach


			<div class="js-zone-container zone-container-main" style="margin-bottom: 24px;">
				<div id="dfp-mlb" class="everyonelovesstackoverflow everyoneloves__mid-leaderboard everyoneloves__leaderboard" style="min-height: auto; height: auto;" data-google-query-id="CKK-w9bosPsCFVTL1Qody-0G6w">
					<div id="google_ads_iframe_/248424177/law.stackexchange.com/mlb/question-pages_0__container__" style="border: 0pt none;"><iframe id="google_ads_iframe_/248424177/law.stackexchange.com/mlb/question-pages_0" name="google_ads_iframe_/248424177/law.stackexchange.com/mlb/question-pages_0" title="3rd party ad content" width="728" height="90" scrolling="no" marginwidth="0" marginheight="0" frameborder="0" role="region" aria-label="Advertisement" tabindex="0" style="border: 0px; vertical-align: bottom;" data-google-container-id="3" data-load-complete="true"></iframe></div>
				</div>
				<div class="js-report-ad-button-container " style="width: 728px"></div>
			</div>

			<a name="new-answer"></a>
			<form id="post-form" action="/questions/85675/answer/submit" method="post" class="js-add-answer-component post-form">
				<h2 class="space" id="your-answer-header">
					Your Answer
				</h2>

				<div id="post-editor" class="post-editor js-post-editor">
					<div class="ps-relative">
						<div class="wmd-container mb8">
							<div class="js-stacks-validation">
								<div class="ps-relative">
									<textarea id="wmd-input" name="post-text" class="wmd-input s-input bar0 js-post-body-field" data-editor-type="wmd" data-post-type-id="2" cols="92" rows="15" aria-labelledby="your-answer-header" tabindex="101" data-min-length=""></textarea>
								</div>
								<div class="s-input-message mt4 d-none js-stacks-validation-message"></div>
							</div>
						</div>
					</div>

				</div>


				<div class="form-submit clear-both d-flex gsx gs4">
					<button id="submit-button" class="flex--item s-btn s-btn__primary s-btn__icon" type="submit" tabindex="120" autocomplete="off">
						Post Your Answer </button>
					<button class="flex--item s-btn s-btn__danger discard-answer dno">
						Discard
					</button>
					<p class="privacy-policy-agreement">
						By clicking “Post Your Answer”, you agree to our <a href="https://stackoverflow.com/legal/terms-of-service/public" name="tos" target="_blank" class="-link">terms of service</a>, <a href="https://stackoverflow.com/legal/privacy-policy" name="privacy" target="_blank" class="-link">privacy policy</a> and <a href="https://stackoverflow.com/legal/cookie-policy" name="cookie" target="_blank" class="-link">cookie policy</a><input type="hidden" name="legalLinksShown" value="1">
					</p>
				</div>
				<div class="js-general-error general-error clear-both d-none" aria-live="polite"></div>
			</form>
		</div>
	</div>
</div>