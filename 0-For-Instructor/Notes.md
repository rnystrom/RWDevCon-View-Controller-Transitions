# Notes

>30 min demo / 15 min lab / 15 min challenge time limits

## intro

- protocols
    + UIViewControllerTransitioningDelegate
        * delegates what happens when presenting, push/popping, dismissing, interacting
    + UIViewControllerAnimatedTransitioning
        * decides what to do for animation as well as duration
    + UIViewControllerContextTransitioning
        * config & state of transition
    + UIViewControllerInteractiveTransitioning
        * nav swipe back, can do way more
        * left for research and reading
- 

## Demo pool

- UIViewControllerTransitioningDelegate
    + show distinction between present/dismiss objects
    + strong ref
- UIViewControllerAnimatedTransitioning
    + duration
    + completion
    + contentView
        * temp view
        * from & to views
        * remove from view
- present
    + getting frame coordinates
    + animating image
    + animating background color
    + create a dummy animation at the beginning
        * selected view, origin rect
        * know where to animate the image
- dismiss
    + animate background color
    + animate image

## 0-Overview

video of what they will make
transition "theory"
ios VC transitions

## 2-Demo

starter project
create coordinator classes
create bogus animation
wire up coordinator

## 3-Lab

get selected view
get origin rect
animate bg
animate view
cleanup

## 4-Challenge

dismiss animation

## 5-Conclusion