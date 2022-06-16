// import footer from './index';
// import './footer.scss';

// export default {
//   title: 'Components/Footer',
// };

// const Template = (args) => footer(args);

// export const Basic = Template.bind({});
// Basic.args = {
//   title: 'Footer title',
// };




export default { title: 'Footer' };

import footer from './footer.html.twig';
import './footer.scss';

export const default_block = () => (
  footer({
    title: 'Footer title'
  })
);