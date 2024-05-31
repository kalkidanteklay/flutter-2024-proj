import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pets/pets/model.dart';

abstract class PetState extends Equatable {
  const PetState();

  @override
  List<Object> get props => [];
}

class PetInitial extends PetState {}

class PetLoading extends PetState {}

class GetPetsLoadedState extends PetState {
  final List<Pet> pets;

  const GetPetsLoadedState(this.pets);

  @override
  List<Object> get props => [pets];
}

class PetAddedSuccess extends PetState {
  final String petId;

  const PetAddedSuccess(this.petId);

  @override
  List<Object> get props => [petId];
}

class PetDeletedSuccess extends PetState {}

class PetUpdatedSuccess extends PetState {}

class GetPetErrorState extends PetState {
  final String message;

  const GetPetErrorState(this.message);

  @override
  List<Object> get props => [message];
}

class PetError extends PetState {
  final String message;

  const PetError(this.message);

  @override
  List<Object> get props => [message];
}
