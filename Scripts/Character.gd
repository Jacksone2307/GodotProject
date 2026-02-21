class_name Character
extends CharacterBody2D


@export var health = 100

func take_damage(damage):
	health -= damage
