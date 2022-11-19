@if ($score == 0)
    <div class="answer-stats-item">
        <span class="answer-stats-score-number">{{$score}}</span>
        <span class="answer-stats-score-unit">votes</span>
    </div>
@elseif ($score < 0)
    <div class="answer-stats-item" style="color: red">
        <span class="answer-stats-score-number">{{$score}}</span>
        <span class="answer-stats-score-unit">votes</span>
    </div>
@else
    <div class="answer-stats-item" style="color: green">
        <span class="answer-stats-score-number">{{$score}}</span>
        <span class="answer-stats-score-unit">votes</span>
    </div>
@endif