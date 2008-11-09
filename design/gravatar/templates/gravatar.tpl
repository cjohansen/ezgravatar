{*?template charset=utf8?*}{*

	Produces an image tag which displays a gravatar.
                                                                                
	The template requires an md5 template operator. The simplest way to
	provide such an operator is through template.ini/[PHP]/PHPOperatorList[],
	ie put the following in an override for template.ini (such as
	settings/override/template.ini.append):

	[PHP]
	PHPOperatorList[md5]=md5

	Input
	email      Email address, either as a string or an attribute whose content
	           is an email address
	size       The desired size of the gravatar. Gravatars are square, so this
                   should be a single integer. Default is 80 (pixles).
	rating     What content to allow. Any of the following (default is X - ie all):
	                G  - A G rated gravatar is suitable for display on all
                             websites with any audience type.
                        PG - PG rated gravatars may contain rude gestures, provocatively
                             dressed individuals, the lesser swear words, or mild violence.
                        R  - R rated gravatars may contain such things as harsh profanity,
                             intense violence, nudity, or hard drug use.
                        X  - X rated gravatars may contain hardcore sexual imagery or
                             extremely disturbing violence.
	default    The default image to serve up if email has no gravatar. This may be
                   an URL to an image, or one of identicon, monsterid and wavatar.
                   If the parameter is an empty string the default blue gravatar logo
                   is used as default. Default may also be the string "random" which
                   will choose either one of the defaults.
	alt        The alt text for the image. Default is "Gravatar"
	class      Optional class name for img tag
	id         When using a random default image you may provide any id/number as a
                   way of selecting default image. This way the pick is not actually random
                   since you'll always get the same gravatar for the same id.

	Christian Johansen (christian at cjohansen.no) 2008-11-09
	www.cjohansen.no
*}
{if not(is_set($size))}{def $size=80}{/if}
{if not(is_set($rating))}{def $rating="X"}{/if}
{if not(is_set($default))}{def $default="random"}{/if}
{if not(is_set($alt))}{def $alt="Gravatar"}{/if}

{if $default|eq("random")}
	{def $defaults=array("", "identicon", "monsterid", "wavatar")}
	{def $num=$defaults|count}

	{if is_set($id)}
		{set $id=$id|mod($num)}
	{else}
		{def $id=rand(0, $num|sub(1))}
	{/if}

	{set $default=$defaults[$id]}
{/if}

{if $default|ne("")}
	{set $default=concat("&amp;d=", $default)}
{/if}

{if is_set($email.content)}
 	{set $email=$email.content}
{/if}

{def $url=concat("http://www.gravatar.com/avatar/", $email|md5, ".jpg?s=", $size, "&amp;r=", $rating, $default)}
<img src={$url|ezurl} alt="{$alt}" width="{$size}" height="{$size}"{if is_set($class)} class="{$class}"{/if} />
