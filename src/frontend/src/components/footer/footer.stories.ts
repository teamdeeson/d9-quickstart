export default { title: 'Footer' };

import footer from './footer.html.twig';
import './footer.scss';

export const defaultFooter = () => (
  footer({
    title: 'Footer title'
  })
);