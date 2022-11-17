<?php

/**
 * Created by Reliese Model.
 */

namespace App\Models;

use Illuminate\Notifications\Notifiable;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Foundation\Auth\User as Authenticatable;

/**
 * Class User
 *
 * @property int $id_user
 * @property string $username
 * @property string $email
 * @property string $password
 * @property string|null $profile_picture
 * @property string|null $personal_text
 *
 * @property Administrator $administrator
 * @property Moderator $moderator
 * @property Collection|Post[] $posts
 * @property Collection|Draft[] $drafts
 * @property Collection|BadgeGiven[] $badge_givens
 * @property Collection|Notification[] $notifications
 * @property Collection|FollowsTag[] $follows_tags
 * @property Collection|FollowsQuestion[] $follows_questions
 * @property Collection|QuestionVote[] $question_votes
 * @property Collection|AnswerVote[] $answer_votes
 * @property Collection|Report[] $reports
 * @property Collection|Edit[] $edits
 *
 * @package App\Models
 */
class User extends Authenticatable
{
    use Notifiable;
    protected $table = 'users';
    protected $primaryKey = 'id_user';
	public $timestamps = false;

	protected $hidden = [
		'password', 'remember_token'
	];

	protected $fillable = [
		'username',
		'email',
		'password',
		'profile_picture',
		'personal_text'
	];

	public function administrator()
	{
		return $this->hasOne(Administrator::class, 'id_admin');
	}

	public function moderator()
	{
		return $this->hasOne(Moderator::class, 'id_moderator');
	}

	public function posts()
	{
		return $this->hasMany(Post::class, 'id_author');
	}

	public function drafts()
	{
		return $this->hasMany(Draft::class, 'id_author');
	}

	public function badge_givens()
	{
		return $this->hasMany(BadgeGiven::class, 'id_user');
	}

	public function notifications()
	{
		return $this->hasMany(Notification::class, 'id_user');
	}

	public function follows_tags()
	{
		return $this->hasMany(FollowsTag::class, 'id_user');
	}

	public function follows_questions()
	{
		return $this->hasMany(FollowsQuestion::class, 'id_user');
	}

	public function question_votes()
	{
		return $this->hasMany(QuestionVote::class, 'id_user');
	}

	public function answer_votes()
	{
		return $this->hasMany(AnswerVote::class, 'id_user');
	}

	public function reports()
	{
		return $this->hasMany(Report::class, 'id_user');
	}

	public function edits()
	{
		return $this->hasMany(Edit::class, 'id_user');
	}
}
