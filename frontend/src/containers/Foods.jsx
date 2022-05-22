import React, { Fragment } from 'react';

export const Foods = ({ match }) => {
  return (
    <Fragment>
      フード一覧
      <p>resraurantsIdは {match.params.restaurantsId} です。</p>
    </Fragment>
  )
}
