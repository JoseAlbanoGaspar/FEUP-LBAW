<?php

/**
 * Created by Reliese Model.
 */

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

/**
 * Class QuestionTag
 *
 * @property int $id_tag
 * @property int $id_question
 *
 * @property Tag $tag
 * @property Question $question
 *
 * @package App\Models
 */
class QuestionTag extends Model
{
	protected $table = 'question_tag';
	public $incrementing = false;
	public $timestamps = false;

	protected $casts = [
		'id_tag' => 'int',
		'id_question' => 'int'
	];

	public function tag()
	{
		return $this->belongsTo(Tag::class, 'id_tag')
//					->where('tag.id_tag', '=', 'question_tag.id_tag')
					->where('tag.id_tag', '=', 'question_tag.id_tag');
	}

	public function question()
	{
		return $this->belongsTo(Question::class, 'id_question')
//					->where('question.id_question', '=', 'question_tag.id_question')
					->where('question.id_question', '=', 'question_tag.id_question');
	}
}
