<?php

/**
 * Created by Reliese Model.
 */

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

/**
 * Class FollowTagNotif
 *
 * @property int $id_notif
 * @property int|null $id_tag
 *
 * @property Notification $notification
 * @property Tag|null $tag
 *
 * @package App\Models
 */
class FollowTagNotification extends Model
{
	protected $table = 'follow_tag_notif';
	public $incrementing = false;
	public $timestamps = false;

	protected $casts = [
		'id_notif' => 'int',
		'id_tag' => 'int'
	];

	protected $fillable = [
		'id_tag'
	];

	public function notification()
	{
		return $this->belongsTo(Notification::class, 'id_notif')
//					->where('notification.id_notif', '=', 'follow_tag_notif.id_notif')
					->where('notification.id_notif', '=', 'follow_tag_notif.id_notif');
	}

	public function tag()
	{
		return $this->belongsTo(Tag::class, 'id_tag')
//					->where('tag.id_tag', '=', 'follow_tag_notif.id_tag')
					->where('tag.id_tag', '=', 'follow_tag_notif.id_tag');
	}
}
